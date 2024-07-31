# Hidden Recon

Are you tired of the same old parameter recognition? active crawling with katana or passive crawling pulling urls from waybackarchive, commoncrawl, alienvault...

Well then maybe this tool is for you.

With the -eih option you can find hidden entries waiting for a value in a web application, formatting in its original url hiddenrecon increases your chance of success in a string reflection.

Empty "data-" custom attributes, are most of the time expecting a value, it won't always come from the url but it's not bad to test xD... for that use -eda

![image](https://github.com/user-attachments/assets/223b8362-198f-49bc-a3b4-a9d084baf41f)

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
cat crawler.txt | ./hiddenrecon.sh -eih -eda
```



