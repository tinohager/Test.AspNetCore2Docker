FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY . ./
#COPY *.csproj ./
RUN cd ./Test.AspNetCore2Docker && dotnet restore
#RUN dotnet restore

# Copy everything else and build
#COPY . ./
RUN cd ./Test.AspNetCore2Docker && dotnet publish -f netcoreapp3.0 -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/runtime:3.0
WORKDIR /app
COPY --from=build-env /app/Test.AspNetCore2Docker/out .
ENV ASPNETCORE_URLS=http://+:5000
ENTRYPOINT ["dotnet", "Test.AspNetCore2Docker.dll"]