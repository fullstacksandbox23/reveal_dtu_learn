FROM node:22.10.0-alpine3.20 AS build
WORKDIR /app
COPY package*.json svelte.config.js ./
# RUN npm install -g pnpm@8.9.2 && \
RUN npm install -g npm@10.9.0 && \
    npm install
COPY . .
RUN npm run build
# Debugging: List contents of /app after build
# RUN echo "Contents of /app after build:" && ls -la /app
# RUN ls -la /app/build

FROM build AS dev
WORKDIR /app
EXPOSE 5173
CMD ["npm", "run", "dev"]

FROM node:22.10.0-alpine3.20
ENV PORT=80
COPY --from=build /app/build /app/
COPY --from=build /app/package*.json /app/
RUN npm ci --omit=dev
RUN chown -R node:node /app
EXPOSE 80
USER node
CMD ["node", "/app/index.js"]
