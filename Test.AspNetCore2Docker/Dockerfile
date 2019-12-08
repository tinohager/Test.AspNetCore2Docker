FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["Test.AspNetCore2Docker/Test.AspNetCore2Docker.csproj", "Test.AspNetCore2Docker/"]
RUN dotnet restore "Test.AspNetCore2Docker/Test.AspNetCore2Docker.csproj"
COPY . .
WORKDIR "/src/Test.AspNetCore2Docker"
RUN dotnet build "Test.AspNetCore2Docker.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Test.AspNetCore2Docker.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Test.AspNetCore2Docker.dll"]