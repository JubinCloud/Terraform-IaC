import boto3, os, uuid, zipfile, io, json, urllib.parse
s3 = boto3.client("s3")

def lambda_handler(event, context):
    # expects JSON body with bucket and keys list OR query params
    try:
        if event.get("body"):
            body = json.loads(event["body"])
        else:
            body = event.get("queryStringParameters", {}) or {}
        bucket = body.get("bucket") or event.get("pathParameters", {}).get("bucket")
        keys = body.get("keys") or (event.get("queryStringParameters", {}).get("keys") or "")
        if isinstance(keys, str):
            keys = keys.split(",") if keys else []
        if not bucket or not keys:
            return {"statusCode":400,"body":"Provide bucket and keys"}
        # create zip in memory
        buf = io.BytesIO()
        with zipfile.ZipFile(buf, "w", zipfile.ZIP_DEFLATED) as zf:
            for k in keys:
                k = k.strip()
                obj = s3.get_object(Bucket=bucket, Key=k)
                data = obj["Body"].read()
                zf.writestr(os.path.basename(k), data)
        buf.seek(0)
        tmp_key = f"temp-zips/{uuid.uuid4()}.zip"
        s3.put_object(Bucket=bucket, Key=tmp_key, Body=buf.read(), ContentType="application/zip")
        # create signed url (short lived)
        url = s3.generate_presigned_url("get_object", Params={"Bucket": bucket, "Key": tmp_key}, ExpiresIn=900)
        return {"statusCode":200,"body": json.dumps({"url": url})}
    except Exception as e:
        return {"statusCode":500,"body":str(e)}
