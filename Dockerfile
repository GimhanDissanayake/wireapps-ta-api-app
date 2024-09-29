FROM node:18-alpine

WORKDIR /usr/src/app

COPY --chown=node:node package.json package-lock.json ./

# Install app dependencies
RUN npm ci --only=production

# Install PM2 globally
RUN npm install pm2 -g

# Bundle app source
COPY --chown=node:node . .

# Expose the port the app runs in
EXPOSE 8080

# Run as a non-root user
USER node

# Serve the app
CMD ["pm2-runtime", "start", "npm", "--", "start"]