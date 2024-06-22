# build
FROM mcr.microsoft.com/dotnet/sdk:8.0.101 AS builder
WORKDIR /app

COPY . ./
RUN dotnet restore dotnet-sample-api.sln && \
    dotnet publish dotnet-sample-api.sln -c Release -o out

# publish
FROM mcr.microsoft.com/dotnet/aspnet:8.0.1 AS publisher
WORKDIR /app

COPY --from=builder /app/out .
EXPOSE 80

ENTRYPOINT ["dotnet", "APIContagem.dll"]
