import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import * as helmet from 'helmet';
import { AppModule } from './app/app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.use(helmet());
  app.enableCors();

  // build the swagger documentation
  const swaggerConfig = new DocumentBuilder()
    .setTitle('Budipest API')
    .setDescription('Interactive documentation for Budipest REST API')
    .setVersion('0.4')
    .addTag('App')
    .addTag('Auth')
    .addTag('Users')
    .addTag('Toilets')
    .addTag('Notes')
    .addTag('Votes')
    .addBearerAuth()
    .build();
  const swaggerDocument = SwaggerModule.createDocument(app, swaggerConfig);
  SwaggerModule.setup('swagger', app, swaggerDocument);

  await app.listen(3000);
}
bootstrap();
