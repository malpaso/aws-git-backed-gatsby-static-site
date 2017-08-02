#!/bin/bash

{
  rm GenerateGatsbyStaticSite.zip
  cd GenerateGatsbyStaticSite; zip -r ../GenerateGatsbyStaticSite.zip *; cd ..;
} &> /dev/null

Version=$(md5sum -b GenerateGatsbyStaticSite.zip | awk '{print $1}')

{
  aws s3 mb s3://lambdas.$DOMAIN_NAME
  aws s3 cp GenerateGatsbyStaticSite.zip s3://lambdas.$DOMAIN_NAME/GenerateGatsbyStaticSite-$Version.zip
  aws s3 cp GenerateGatsbyStaticSite.zip s3://lambdas.$DOMAIN_NAME/GenerateGatsbyStaticSite-latest.zip
  rm GenerateGatsbyStaticSite.zip
} &> /dev/null

echo $Version
