# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /source
EXPOSE 5000

COPY ./*.csproj ./orders.service/
RUN dotnet restore ./orders.service/*.csproj

COPY . ./orders.service/
WORKDIR /source/orders.service
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/sdk:9.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT [ "dotnet", "orders.service.dll" ]