# 99 Bottles of Beer, Amiga style
Implements the song "99 Bottles of Beer on the Wall" in a CLI window.

# What's an Amiga?
Used to be the future. 

Seriously, though, an explanation would take too long. Suffice to say it was a 7 MHz home computer produced by Commodore when I was a boy. At least 10 years ahead of its time, it regularly ran rings around machines with ten times the clock speed and memory. To this day, it remains my favorite computer.

# So what's this?
Well, you see, there's this old drinking song (possibly apocryphal) that starts, "99 bottles of beer on the wall...". The lyrics repeat one hundred times, then the song ends. It's like the Ten Days of Christmas, only it'll leave you without a functioning liver.

I thought I'd do something with the concept, so I produced this monstrosity. When run, the 99bottles routine prints out the lyrics of the song in CLI. That's all it does. Although in fairness, it does its particular job very well indeed: Assembler can be tortured into a most compact form if you apply yourself.

For developers used to modern systems, it also has its pitfalls. Previous versions broke compatibility with any OS version before 2.0, because I make stupid mistakes. This evinced itself in the application promptly crashing any Amiga that wasn't OS 2.0 or above. That grated on me, so I decided to finally get a working version up on GitHub. Now I can finally stick a fork in this bastard and pronounce it done.

# Isn't this program useless? I mean, entirely useless? Why write this?
Yes, yes, and for two reasons. 

One, I always wanted to learn Assembler, and it turned out to be surprisingly fun. Two, it's an exercise in optimization and really, truly understanding both the code and the underlying hardware.

Optimization is for size, not speed, by the way. In terms of speed, this routine is wasteful.

# How's that, exactly?
Modern platforms have all the memory and number-crunching power you need. That breeds laziness. The Amiga doesn't reward that: it rewards exactitude and, to some degree, art. When you write code like this, you learn to be creative. You need to be. 

My original executable was 624 bytes in size, and didn't work on an A500. This one is 404 bytes, and can be optimized further. Not that I feel so inclined at the moment.

Anyhow, painstaking optimization forced me to learn the code, which was surprisingly useful. This is fairly simple code, but even so, I found at least five fatal bugs, all because I had to pay attention.

# What were the lessons learned, then?
* With just a bit of thought, you can write fairly efficient code without sacrificing clarity.
* If you go beyond that, you can achieve dramatic gains in speed and/or memory footprint, at the cost of flexibility and clarity.
* What happens under the hood of the computer is always simpler than you think.
* If you can manipulate data in a register, do it.
* Organization of your code can matter on a byte level (i.e. jumps can be made shorter, addressing made PC-relative, and string data reused).
* Don't assume the hardware will be a blank slate on execution of your code.
* Loading things into register looks more verbose, but is generally more compact and produces better/more flexible code.
* Don't overthink. Cutting text up into chunks looked more efficient (allowing for reuse, I thought), but in practice turned out the reverse.
* Correct choice of algorithm will have a much bigger impact on your code than piecemeal tweaking.
* Always comment. Your comments are what help you spot opportunity for improvements.
* Don't overcomment. Since Assembler is so low-level, there's not a lot of semantic meaning in individual instructions, so comment judiciously.  
* Seriously, OS 2.0 was a massive improvement. I mean it.

# Does this have any practical applications?
Unless you're soon to be stuck in a cabin in the woods with only an Amiga and a lot of beer for company, I doubt it. If by some chance this actually happens to you and my code managed to be of assistance, I would be absolutely _delighted_ to hear from you.
