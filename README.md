When approaching a target, getting as much information as possible about the target is critical to penetration testing. Good old bruteforcing is one way that can be used to enumerate details about a particular target such as its subdomains, URL paths, javascript files etc.

Bruteforcing usually requires you to have wordlists with which you will run the brute force attack. The wordlists can be public, such as those found in the (Seclists Repository)[https://github.com/danielmiessler/SecLists] or they can be your own custom wordlists. Either way, you'll need your wordlists to be as exhaustive as possible in order to get the best results.

Assume a directory structure such as:

*Subdomains
  *subdomainwordlist1.txt
  *subdomainwordlist2.txt
*Directories
  *directorywordlist1.txt
  *directorywordlist2.txt
  
which has two directories, each with multiple wordlists.

Running this tool against any of the two directories will result in one file that contains the content of all the wordlists within the directory. This provides you with one wordlist that you can use to fuzz your target, making sure you don't miss anything.
