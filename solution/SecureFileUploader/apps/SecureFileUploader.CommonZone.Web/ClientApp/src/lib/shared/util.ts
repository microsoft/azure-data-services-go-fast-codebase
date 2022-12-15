export const objToQS = (obj: URLSearchParams) =>
  Object.keys(obj)
    .map(key => `${key}=${obj.get(key)}`)
    .join('&');