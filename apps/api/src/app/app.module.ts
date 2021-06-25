import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { SequelizeModule } from '@nestjs/sequelize';
import configuration from 'config/configuration';
import { AuthModule } from 'src/auth/auth.module';
import { User } from 'src/users/users.model';
import { UsersModule } from 'src/users/users.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';

const preConfiguration = configuration();

@Module({
  imports: [
    UsersModule,
    AuthModule,
    SequelizeModule.forRoot({
      dialect: 'postgres',
      host: preConfiguration.database.host,
      port: preConfiguration.database.port,
      username: preConfiguration.database.username,
      password: preConfiguration.database.password,
      database: preConfiguration.database.database,
      models: [User],
    }),
    ConfigModule.forRoot({
      load: [configuration],
      isGlobal: true,
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
