import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './module/auth/auth.module';
import { StoreModule } from './module/store/store.module';
import { PrismaModule } from './module/prisma/prisma.module';

@Module({
  imports: [AuthModule, StoreModule, PrismaModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
