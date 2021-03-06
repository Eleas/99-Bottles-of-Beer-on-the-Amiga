# 99 Bottles of Beer, Amiga style
Implements the song "99 Bottles of Beer on the Wall" in a CLI window.

# What's an Amiga?
Used to be the future. 

Seriously, though, an explanation would take too long. Suffice to say it was a 7 MHz home computer produced by Commodore when I was a boy. It was at least 10 years ahead of its time, and regularly ran rings around machines with ten times the clock speed. To this day, it remains my favorite computer.

# So what's this?
Well, you see, there's this old drinking song / joke that starts, "99 bottles of beer on the wall...". When run, this routine prints out the song in the CLI window on the Amiga. This works only on OS 2.0 and up, because I make stupid mistakes.

# Isn't this program useless? I mean, entirely useless? Why write this?
Yes, yes, and for two reasons. 

One, I always wanted to learn Assembly, and it turned out to be surprisingly fun. Two, it's an exercise in optimization and really, truly understanding both the code and the underlying hardware.

# How's that, exactly?
Modern platforms have all the memory and number-crunching power you need. That breeds laziness. The Amiga doesn't reward that: it rewards exactitude and, to some degree, art. When you write code like this, you learn to be creative. You need to be. 

The original executable was 624 bytes in size. Just by optimizing and being moderately clever I was able to trim off 76 bytes while retaining readability. By hook and crook, and finally sacrificing legibility, I eventually shaved off another 92 bytes. And in a fit of insanity, I then doubled down to bring it down another 64 bytes, to 396 bytes. I could go another 10 or so, I think, but I doubt there's much more give in the data at this point.

Anyhow, painstaking optimization forced me to learn the code, which was surprisingly useful. This is fairly simple code, but even so, I found at least two fatal bugs, all because I had to pay attention.

# What were the lessons learned, then?
* With a bit of thought, you can write fairly efficient code without sacrificing clarity.
* What happens under the hood of the computer is always simpler than you think.
* If you can manipulate data in a register, do it.
* Organization of your code can matter on a byte level (i.e. jumps can be made shorter, addressing made PC-relative, and string data reused).
* Don't assume the hardware will be a blank slate on execution of your code.
* Loading things into register looks more verbose, but is generally more compact and produces better/more flexible code.
* Don't overthink. Cutting text up into chunks looked more efficient (allowing for reuse, I thought), but in practice turned out the reverse.
* Correct choice of algorithm will have a much bigger impact on your code than piecemeal tweaking.
* Always comment. Your comments are what help you spot opportunity for improvements.
* Seriously, OS 2.0 was a massive improvement. I mean it.

# Does this have any practical application?
Unless you're soon to be stuck in a cabin in the woods with only an A500 and a lot of beer for company, I doubt it. If by some chance this actually happens to you and my code managed to be of assistance, I would be absolutely _delighted_ to hear from you.
