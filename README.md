# NOTES API

This is a technical demonstration app designed to show profeciency with AWS Services, Terraform, GitHub Actions, Typescript and more.

## Technical Requirements

Build an API with the following tools:

- [x] Create a serverless API application with the following features:
  - [x] Ability to create, edit, update and delete folders
  - [x] Ability to create, edit update and delete notes
  - [x] Ability to add notes to folders
  - [x] Ability to move notes between folders
- [x] The application should be deployed with Terraform
- [x] The application code should be written in Node.JS with Typescript
- [x] The API should be managed by AWS API Gateway
- [ ] The API should be authorized with AWS Cognito and user pools
- [x] The application code should be deployed via AWS Lambdas
- [x] The lambdas should be broken into two services:
  - [x] Folder Service
  - [x] Note Service
- [x] Each service lambda should use Middy for routing and middleware
- [x] Each service endpoint should be validated with Zod
- [x] Each service should use common utilities from a root level utils folder
- [x] Each service should be packaged with Serverless Framework
- [x] The folders and notes should be stored in DynamoDB
  - [x] The table should be architected to use a composite key design to show relations between folders and notes
- [x] The API hould be documented with Swagger
- [x] Deployment should be handled via GitHub Actions
- [ ] Each service function and repository function should have associates Jest tests
