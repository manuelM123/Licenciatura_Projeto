module.exports = ({ env }) => ({
  auth: {
    secret: env('ADMIN_JWT_SECRET', 'c85586a389a8c3c7638f614a671154f4'),
  },
});
