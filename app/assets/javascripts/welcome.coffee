dashBoardApp = angular.module('dashBoardApp', [])
dashBoardApp.directive 'donutChart', ->

  link = (scope, el, attr) ->
    color = d3.scale.category10()
    data = scope.data
    width = 300
    height = 300
    min = Math.min(width, height)
    svg = d3.select(el[0]).append('svg')
    pie = d3.layout.pie().sort(null)
    arc = d3.svg.arc().outerRadius(min / 2 * 0.9).innerRadius(min / 2 * 0.5)
    svg.attr
      width: width
      height: height
    g = svg.append('g').attr('transform', 'translate(' + width / 2 + ',' + height / 2 + ')')
    # add the <path>s for each arc slice
    g.selectAll('path').data(pie(data)).enter().append('path').style('stroke', 'white').attr('d', arc).attr 'fill', (d, i) ->
      color i
    return

  {
    link: link
    restrict: 'E'
    scope: data: '='
  }

dashBoardApp.directive 'helloWorld', ->

  link = (scope, el, attr) ->




    data = [4, 8, 15, 16, 23, 42];

    x = d3.scale.linear()
              .domain([0, d3.max(data)])
              .range([0, 420]);

    d3.select(el[0]).selectAll("div").data(data).enter().append("div")
    .style("width", (d) -> x(d) + 'px')
    .text((d)-> return d; );


        
dashBoardApp.directive 'barGraph', ->

  link = (scope, el, attr) ->
   

      #Width, height, padding
    w = 370
    h = 250
    padding = 25
    #Array of dummy data values
    dataset = [
      5
      10
      13
      19
      21
      25
      22
      18
      15
      13
      11
      12
      15
      20
      18
      17
      16
      18
      23
      25
    ]
    #Configure x and y scale functions
    xScale = d3.scale.ordinal().domain(d3.range(dataset.length)).rangeRoundBands([
      padding
      w - padding
    ], 0.05)
    yScale = d3.scale.linear().domain([
      0
      d3.max(dataset)
    ]).rangeRound([
      h - padding
      padding
    ])
    #Configure y axis generator
    yAxis = d3.svg.axis().scale(yScale).orient('left').ticks(5)
    #Create SVG element
    svg = d3.select(el[0]).append('svg').attr('width', w).attr('height', h)
    #Create bars
    rects = svg.selectAll('rect').data(dataset).enter().append('rect').attr('x', (d, i) ->
      xScale i
    ).attr('y', (d) ->
      h - padding
    ).attr('width', xScale.rangeBand()).attr('height', 0).attr('fill', 'SteelBlue').on('mouseover', ->
      #Update fill on mouseover
      d3.select(this).attr 'fill', 'Maroon'
      return
    ).on('mouseout', ->
      #Update fill on mouseout
      d3.select(this).attr 'fill', (d) ->
        if d > 20
          return 'DarkOrange'
        'SteelBlue'
      return
    )
    #Transition rects into place
    rects.transition().delay((d, i) ->
      i * 100
    ).duration(1500).attr('y', (d) ->
      yScale d
    ).attr('height', (d) ->
      h - padding - yScale(d)
    ).transition().duration(500).attr 'fill', (d) ->
      if d > 20
        return 'DarkOrange'
      'SteelBlue'
    #Create y axis
    svg.append('g').attr('class', 'axis').attr('transform', 'translate(' + padding + ',0)').attr('opacity', 0).call(yAxis).transition().delay(2000).duration(1500).attr 'opacity', 1.0

                  






dashBoardApp.directive 'map', ->

  link = (scope, el, attr) ->

    #Width and height
    w = 500
    h = 300
    #Define map projection
    projection = d3.geo.mercator().center([
      0
      40
    ]).translate([
      w / 2
      h / 2
    ]).scale([ w / 7 ])
    #Define path generator
    path = d3.geo.path().projection(projection)
    #Create SVG
    svg = d3.select(el[0]).append('svg').attr('width', w).attr('height', h)
    #Load in GeoJSON data
    d3.json 'https://data.lacity.org/resource/6rrh-rzua.json?&$$app_token=klRm5Wi5CpoRFhLpFJbwfXbn7', (json) ->
      #Bind data and create one path per GeoJSON feature
      svg.selectAll('path').data(json.features).enter().append('path').attr 'd', path
      return