
let ma = document.getElementById('ma');
let sh = document.getElementById('sh');
let cl = document.getElementById('cl');
let dr = document.getElementById('dr');
let sw = document.getElementById('sw');
let ca = document.getElementById('ca');

let martial_arts = document.getElementById('martial_arts');
    martial_arts.addEventListener('click', function() {
        if (ma.innerHTML == "　") {
            ma.innerHTML = "Martial Arts!"
        }else{
            ma.innerHTML = "　"
        }
    })

let shooting = document.getElementById('shooting');
    shooting.addEventListener('click', function() {
        if (sh.innerHTML == "　") {
            sh.innerHTML = "Marksmanship!"
        }else{
            sh.innerHTML = "　"
        }
    })

let climbing = document.getElementById('climbing');
    climbing.addEventListener('click', function() {
        if (cl.innerHTML == "　") {
            cl.innerHTML = "Mountaineering!"
        }else{
            cl.innerHTML = "　"
        }
    })

let swimming = document.getElementById('swimming');
    swimming.addEventListener('click', function() {
        if (sw.innerHTML == "　") {
            sw.innerHTML = "Swimming!"
        }else{
            sw.innerHTML = "　"
        }
    })

let driving = document.getElementById('driving');
    driving.addEventListener('click', function() {
        if (dr.innerHTML == "　") {
            dr.innerHTML = "Driving!"
        }else{
            dr.innerHTML = "　"
        }
    })

let casino = document.getElementById('casino');
    casino.addEventListener('click', function() {
        if (ca.innerHTML == "　") {
            ca.innerHTML = "Gambling!"
        }else{
            ca.innerHTML = "　"
        }
    })

