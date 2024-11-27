// Start line chart =======================>
var chart = c3.generate({
    bindto: '#lineChart',
    data: {
        columns: [
            ['data1', 30, 200, 100, 400, 150, 250],
            ['data2', 50, 20, 10, 40, 15, 25]
        ]
    },
    color: {
        pattern: ['#77BAE5', '#F68685', '#EC5051', '#6586A7', '#96D3C4', '#F4B264', '#F78CB8', '#7B879D', '#B76FD2', '#A2D6B2', '#D6C1C8', '#DF9F17', '#76D2A1']
    },
});
// End line chart =======================>



// Start Step  chart =======================>
var chart = c3.generate({
    bindto: '#stepChart',
    data: {
        columns: [
            ['data1', 300, 350, 300, 0, 0, 100],
            ['data2', 130, 100, 140, 200, 150, 50]
        ],
        types: {
            data1: 'step',
            data2: 'area-step'
        }
    },
    color: {
        pattern: ['#77BAE5', '#F68685', '#EC5051', '#6586A7', '#96D3C4', '#F4B264', '#F78CB8', '#7B879D', '#B76FD2', '#A2D6B2', '#D6C1C8', '#DF9F17', '#76D2A1']
    },
});
// End Step  chart =======================>



// Start bar chart =======================>
var chart = c3.generate({
    bindto: '#barChart',
    data: {
        columns: [
            ['data1', 30, 200, 100, 400, 150, 250],
            ['data2', 130, 100, 140, 200, 150, 50]
        ],
        type: 'bar'
    },
    color: {
        pattern: ['#77BAE5', '#F68685', '#EC5051', '#6586A7', '#96D3C4', '#F4B264', '#F78CB8', '#7B879D', '#B76FD2', '#A2D6B2', '#D6C1C8', '#DF9F17', '#76D2A1']
    },
    bar: {
        width: {
            ratio: 0.5 // this makes bar width 50% of length between ticks
        }
        // or
        //width: 100 // this makes bar width 100px
    }
});
// End bar chart =======================>



// Start pie chart =======================>
var chart = c3.generate({
    bindto: '#pieChart',
    data: {
        // iris data from R
        columns: [
            ['Banana', 44],
            ['Apple', 78],
            ['Orange', 34],
            ['Grape', 53],
            ['Pineapple', 23],
            ['Mango', 35],
        ],
        type: 'pie',
        onclick: function (d, i) { console.log("onclick", d, i); },
        onmouseover: function (d, i) { console.log("onmouseover", d, i); },
        onmouseout: function (d, i) { console.log("onmouseout", d, i); }
    },
    color: {
        pattern: ['#77BAE5', '#F68685', '#EC5051', '#6586A7', '#96D3C4', '#F4B264', '#F78CB8', '#7B879D', '#B76FD2', '#A2D6B2', '#D6C1C8', '#DF9F17', '#76D2A1']
    },
});
// End pie chart =======================>



// Start Donut Chart =======================>

var chart = c3.generate({
    bindto: '#donutChart',
    data: {
        columns: [
            ['Banana', 44],
            ['Apple', 78],
            ['Orange', 34],
            ['Grape', 53],
            ['Pineapple', 23],
            ['Mango', 35],
        ],
        type: 'donut',
        onclick: function (d, i) { console.log("onclick", d, i); },
        onmouseover: function (d, i) { console.log("onmouseover", d, i); },
        onmouseout: function (d, i) { console.log("onmouseout", d, i); }
    },
    color: {
        pattern: ['#77BAE5', '#F68685', '#EC5051', '#6586A7', '#96D3C4', '#F4B264', '#F78CB8', '#7B879D', '#B76FD2', '#A2D6B2', '#D6C1C8', '#DF9F17', '#76D2A1']
    },
    donut: {
        title: "Iris Petal Width"
    }
});

// End Donut Chart =======================>



// Start Area Chart =======================>

var chart = c3.generate({
    bindto: '#areaChart',
    data: {
        columns: [
            ['Alu', 100, 50, 40, 90, 30, 43],
            ['Kumra', 200, 50, 40, 90, 30, 43],
            ['Tomato', 40, 70, 40, 90, 30, 43]
        ],
        types: {
            Alu: 'area-spline',
            Kumra: 'area-spline',
            Tomato: 'area-spline'
        }
    },
    color: {
        pattern: ['#77BAE5', '#F68685', '#EC5051', '#6586A7', '#96D3C4', '#F4B264', '#F78CB8', '#7B879D', '#B76FD2', '#A2D6B2', '#D6C1C8', '#DF9F17', '#76D2A1']
    },
});


// End Area Chart =======================>
