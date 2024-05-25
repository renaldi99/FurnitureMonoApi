FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as build-project
WORKDIR /App

COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine as runtime
WORKDIR /App
COPY --from=build-project /App/out .
ENTRYPOINT ["dotnet", "FurnitureMonoApi.dll"]