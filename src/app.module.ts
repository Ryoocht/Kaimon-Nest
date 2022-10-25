import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './module/auth/auth.module';
import { StoreModule } from './module/store/store.module';
import { PrismaModule } from './module/prisma/prisma.module';
import { UserController } from './module/user/user.controller';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    StoreModule,
    PrismaModule,
  ],
  controllers: [AppController, UserController],
  providers: [AppService],
})
export class AppModule {}
