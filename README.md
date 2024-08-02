# Hidden Recon

Are you tired of the same old parameter recognition? active crawling with katana or passive crawling pulling urls from waybackarchive, commoncrawl, alienvault...

Well then maybe this tool is for you.

With the -ihs option you can find hidden entries waiting for a value in a web application, formatting in its original url hiddenrecon increases your chance of success in a string reflection.

Empty "data-" custom attributes, are most of the time expecting a value, it won't always come from the url but it's not bad to test xD... for that use -eda

I created hiddenrecon based on the "Airi" tool from my personal friend @ferreiraklet, please take a look, it's an incredible tool! https://github.com/ferreiraklet/airi

![image](https://github.com/user-attachments/assets/43171c11-1244-49e5-9736-950dc905bc0e)

# What exactly does the tool do?
```-ihs```

![image](https://github.com/user-attachments/assets/0c9d30ab-15d7-448a-8ac9-835678e0fb8b)


Installation
```bash
▶ git clone https://github.com/foorw1nner/hiddenrecon.git
▶ cd hiddenrecon
▶ chmod +x hiddenrecon.sh
```

Usage
```bash
[buffers] | ./hiddenrecon.sh [flags]
```

Example
```bash
cat urls.txt | ./hiddenrecon.sh -ihs -eda
```



