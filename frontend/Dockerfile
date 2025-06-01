FROM node:18
WORKDIR /app
COPY package.json .
RUN npm install --verbose || (sleep 5 && npm install --verbose)
COPY . .
RUN npm run build
CMD ["npm", "start"]
