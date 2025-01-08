# Notes API

This is a tech demo to show proficiency with various services, languages and skills. It is a simple notes app where you can create folders and notes, edit, delete and retrieve them.

## Technical Requirements

- Create a serverless API application with the following features:
  - Ability to create, edit, update and delete folders
  - Ability to create, edit update and delete notes
  - Ability to add notes to folders
  - Ability to move notes between folders
- The application should be deployed with Terraform
- The application code should be written in Node.JS with TypeScript
- The API should be managed by AWS API Gateway using an HTTP API (not REST API)
- The API should be authorized with AWS Cognito and user pools
- The application code should be deployed via AWS Lambdas
- The lambdas should be broken into two services:
  - Folder Service
  - Note Service
- Each service lambda should use Middy for routing and middleware
- Each service endpoint should be validated with Zod
- Each service should use common utilities from a root level utils folder
- Each service should be packaged with Serverless Framework
- The folders and notes should be stored in DynamoDB
  - The table should be architected to use a composite key design to show relations between folders and notes
- The API should be documented with Swagger
- Deployment should be handled via GitHub Actions
- Each service function and repository function should have associated Jest tests

## Technologies Used

- API Gateway (via HTTP API)
- DynamoDB (via Dynamoose)
- ESLint
- Git
- GitHub Actions
- IAM Permissions
- Lambda Functions
- Middy
- Node.JS
- Prettier
- Serverless Framework
- Swagger (YAML)
- Terraform
- TypeScript
