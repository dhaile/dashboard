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