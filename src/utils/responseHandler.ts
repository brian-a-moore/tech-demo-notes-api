import { APIGatewayProxyResult } from "aws-lambda";

const defaultResponseBodyMap = new Map([
  [200, { message: "Success" }],
  [404, { message: "Not Found" }],
  [405, { message: "Method Not Allowed" }],
  [501, { message: "Not Implemented" }],
]);

export const response = ({
  status = 200,
  data,
}: {
  status?: number;
  data?: any;
}): APIGatewayProxyResult => ({
  statusCode: status,
  body: JSON.stringify(data || defaultResponseBodyMap.get(status)),
});
