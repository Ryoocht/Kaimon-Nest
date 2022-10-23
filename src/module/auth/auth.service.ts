import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import * as argon from 'argon2';
import { SignupDto } from './dto/signup.dto';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
  constructor(private prisma: PrismaService) {}

  async login(dto: LoginDto) {
    return 'loggin in';
  }

  async signup(dto: SignupDto) {
    // Generate the Password Hash
    const hash = await argon.hash(dto.password);
    // Save the New User in the DB
    const user = await this.prisma.user.create({
      data: {
        firstName: dto.fistName,
        lastName: dto.lastName,
        email: dto.email,
        password: hash,
        phoneNumber: dto.phoneNumber,
        avatar: dto.avatar,
        role: dto.role,
      },
    });
    return user;
  }
}
