export default () => ({
  secret: process.env.SECRET || 'SamuelLJackonsInATarantinoMovie',
  database: {
    host: process.env.DATABASE_HOST || 'localhost',
    port: parseInt(process.env.DATABASE_PORT, 10) || 5437,
    username: process.env.DATABASE_USERNAME || 'budipest',
    password: process.env.DATABASE_PASSWORD || 'bdpst1234',
    database: process.env.DATABASE_DB || 'budipest_development',
  },
});
