✅ Deployment Notes

Package Lambda before applying Terraform:

cd lambda/zipper
zip -r ../../infra/zipper.zip .
cd ../../infra
terraform init
terraform apply


Terraform will create:

Lambda function s3-zip-downloader-zipper

HTTP API Gateway with /zip POST endpoint

IAM role with S3 read/write

After deploy, you can run:

terraform output api_endpoint
# Example: https://abcd1234.execute-api.us-east-1.amazonaws.com


Call API:

curl -X POST https://abcd1234.execute-api.us-east-1.amazonaws.com/zip \
  -H "Content-Type: application/json" \
  -d '{"bucket":"my-bucket","keys":["file1.png","file2.pdf"]}'


Response will return signed URL to download a zip of the requested S3 objects.