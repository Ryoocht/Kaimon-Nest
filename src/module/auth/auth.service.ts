import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import * as argon from 'argon2';
import { LoginDto, SignupDto } from './dto';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';

@Injectable()
export class AuthService {
  constructor(private prisma: PrismaService) {}

  async login(dto: LoginDto) {
    return 'loggin in';
  }

  async signup(dto: SignupDto) {
    try {
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
        // Select Entity to Return
        select: {
          id: true,
          firstName: true,
          lastName: true,
          email: true,
          phoneNumber: true,
          createdAt: true,
          password: true,
        },
      });
      // Delete Specific Entities
      delete user.password;

      // Return User Object
      return user;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Credentials Taken');
        }
      }
      throw error;
    }
  }
}
