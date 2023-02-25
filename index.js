function main(file) {
    const fs = require("fs")
    if (!file) throw new Error("Please, Input a file.")
    var fileContent = fs.readFileSync(file).toString().replace(/────────────────────────────────────────/g, "").split('\n');

    var objects = [];
    var obj = {};

    var parsedCookies = ""
    fileContent.forEach(line => {
        if (!line) return
        if (line.startsWith('Browser')) {
            obj = {};
            objects.push(obj);
        }
        const parts = line.split(': ');
        obj[parts[0]] = parts[1] + (parts[2] ? ": " + parts[2] : "")
    });

    objects.forEach(r => parsedCookies += r.Host + "	TRUE	/	FALSE	2597573456	" + r.Name + "	" + r.Value + "\n")

    fs.writeFileSync("./parsed-cookies.txt", parsedCookies)
    console.log(`Parsed: ${__dirname}/parsed-cookies.txt`)
}


console.log("-> Drag Your Cookies File Here: ")
process.stdin.on("data", data => {
    data = data.toString().split(/\r\n/)[0]
    if (data.startsWith('"') && data.endsWith('"')) data = data.slice(1, -1)
    main(data)
})