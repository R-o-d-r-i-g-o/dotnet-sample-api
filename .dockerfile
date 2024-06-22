# build
FROM mcr.microsoft.com/dotnet/sdk:8.0.101 AS builder
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

# publish
FROM mcr.microsoft.com/dotnet/aspnet:8.0.1 AS publisher
WORKDIR /app

COPY --from=builder /app/out .
EXPOSE 80

ENTRYPOINT ["dotnet", "APIContagem.dll"]
