# 99-Bottles-of-Beer-on-the-Amiga
Being an implementation of "99 Bottles of Beer on the Wall" for the Commodore Amiga.

# What's an Amiga?
It used to be the future. 

Seriously, though, an explanation would take too long. Suffice to say it was an 8 MHz microcomputer that was at least 10 years ahead of its day. It's still my favorite computer.

# So what's this?
Well, you see, there's this old drinking song / joke that starts, "99 bottles of beer on the wall...". When run, this routine prints out that song in the CLI of the Amiga.

# Isn't this program useless? I mean, entirely useless? Why write this?
For two reasons. One, I always wanted to learn Assembly, and it turned out to be surprisingly fun. Two, it's an exercise in optimization and really, truly understanding both your code and the hardware you use.

# How's that, exactly?
Modern platforms have all the memory you need. That breeds laziness. The Amiga doesn't reward that: it rewards exactitude. When you write code like this, you learn to be creative. You have to be. 

The original executable was 624 bytes in size. Just by optimizing and being moderately clever I was able to trim 40 bytes while retaining readability. Knowing the code intimately turned out adventageous. This is fairly simple code, but even so, I found at least two fatal bugs, all because I had to pay attention.

# What were the lessons learned, then?
* With a bit of thought, you can write efficient code without sacrificing clarity.
* What happens under the hood of the computer is always simpler than you think.
* If you can manipulate data in a register, do it.
* Organization of your code can matter on a byte level (i.e. jumps can be made shorter).
* Don't assume the hardware will be a blank slate on execution of your code.
