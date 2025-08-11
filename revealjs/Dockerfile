FROM node:22.10.0-alpine3.20 AS build
WORKDIR /app
# RUN npm install -g npm@10.9.0
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

FROM build AS dev
WORKDIR /app
EXPOSE 8000
EXPOSE 35729
# CMD ["npm", "start"]
CMD ["npx", "gulp", "serve", "--host", "0.0.0.0"]

# inspired by https://pptr.dev/troubleshooting#running-on-alpine
# to add puppetter headless browser support for testing:
FROM build AS test
WORKDIR /app
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    yarn
# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
# Puppeteer v13.5.0 works with Chromium 100.
RUN npm install puppeteer@13.5.0
# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -G pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads /app \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /app
USER pptruser
COPY --from=build /app .
CMD ["npm", "run", "test"]

FROM node:22.10.0-alpine3.20
WORKDIR /app
COPY --from=build /app/dist dist
COPY --from=build /app/plugin plugin
# TBD: add in all the files and directories that are supposed to get published here
COPY --from=build /app/demo.html .
COPY --from=build /app/index.html .
COPY --from=build /app/_library ./_library
COPY --from=build /app/_reveal ./_reveal
COPY --from=build /app/DAS_DAGA_2025_Epp_etal ./DAS_DAGA_2025_Epp_etal
COPY --from=build /app/DTU-22051 ./DTU-22051
COPY --from=build /app/ISH_2025_Epp_etal ./ISH_2025_Epp_etal
COPY --from=build /app/MOH_2024_Epp_etal ./MOH_2024_Epp_etal
EXPOSE 80
CMD ["npx", "http-server", "-p", "80"]