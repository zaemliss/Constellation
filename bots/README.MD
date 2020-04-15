** Twitter bot ** 
also has discord integration code as an example and some rudimentary searching/triggers 

** Telegram bot is an anti-spam bot I made but has all the functions required to search and act on input **
To use as-is (as an anti-spam bot) it requires a rules.json file formatted as such
```JSON
{
    "rule01": { "name": "press this link", "weight": 3 },
    "rule02": { "name": "money",  "weight": 1 },
    "rule03": { "name": "make",  "weight": 1 },
    "rule04": { "name": "contact me",  "weight": 2 },
    "rule05": { "name": "mining bitcoin and crypto",  "weight": 1 },
    "rule06": { "name": "no scam",  "weight": 2 },
    "rule07": { "name": "want to earn",  "weight": 2 },
    "rule08": { "name": "do you which to learn",  "weight": 3 },
    "rule09": { "name": "learn how to earn",  "weight": 3 },
    "rule10": { "name": "me for details",  "weight": 3 },
    "rule11": { "name": "vip",  "weight": 1 },
    "rule12": { "name": "pump",  "weight": 1 },
    ...
    "rule20": { "name": "dump",  "weight": 1 }
}
```
