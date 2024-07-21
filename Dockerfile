# Stage 1: Build the project
FROM node:20 AS build

WORKDIR /usr/src/app

# Copy package.json and yarn.lock to install dependencies
COPY package*.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy Prisma schema and generate client
COPY prisma ./prisma
RUN yarn prisma generate

# Copy the rest of the project files
COPY . .

# Build the project
RUN yarn run build

# Stage 2: Create the final image
FROM node:20

WORKDIR /usr/src/app

# Copy only the built files from the build stage
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package*.json . 
COPY --from=build /usr/src/app/prisma ./prisma

# Expose the ports the app runs on
EXPOSE 8080
EXPOSE 8081

# Run the application
CMD ["node", "dist/main"]

# docker build . -t img-flynext-be

# docker run -d -p 8080:8080 -p 8081:8081 --name cons-flynext-be img-flynext-be
