import middy from "@middy/core";
import cors from "@middy/http-cors";
import httpErrorHandler from "@middy/http-error-handler";
import jsonBodyParser from "@middy/http-json-body-parser";
import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";

const handler = async (
  event: APIGatewayProxyEvent,
): Promise<APIGatewayProxyResult> => {
  try {
    return {
      statusCode: 200,
      body: JSON.stringify({ message: "Hello world!" }),
    };
  } catch (e: any | unknown) {
    return {
      statusCode: 500,
      body: JSON.stringify({ message: "Internal Server Error" }),
    };
  }
};

export const main = middy(handler)
  .use(jsonBodyParser())
  .use(httpErrorHandler())
  .use(cors());
