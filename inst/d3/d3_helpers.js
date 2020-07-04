function setup_svg_canvas_overlap({ div, width, height, margins }) {
  // Get the device pixel ratio, falling back to 1.
  const dpr = window.devicePixelRatio || 1;

  // Append the canvas
  const canvas = div
    .append("canvas")
    .style("position", "absolute")
    .attr("width", width * dpr)
    .attr("height", height * dpr)
    .style("width", `${width}px`)
    .style("height", `${height}px`)
    .style("left", 0)
    .style("top", 0);

  const context = canvas.node().getContext("2d");

  // Scale canvas image so it looks good on retina displays
  context.scale(dpr, dpr);

  const svg = div
    .append("svg")
    .attr("height", height)
    .attr("width", width)
    .style("position", "absolute")
    .style("left", 0)
    .style("top", 0)
    .call(add_blur_filter);

  const g = svg
    .append("g")
    .attr("transform", `translate(${margins.left},${margins.top})`);

  return {
    canvas,
    context,
    svg,
    g,
    w: width - margins.left - margins.right,
    h: height - margins.top - margins.bottom,
  };
}

function extend_ticks(g, tick_width, tick_opacity = 0.8) {
  g.selectAll(`.tick line`)
    .attr("x2", tick_width)
    .attr("stroke", "white")
    .attr("stroke-opacity", tick_opacity)
    .attr("pointer-events", "none"); // dont let ticks mess up hover etc.

  g.selectAll(`.tick text`).attr("x", -2);
}

function remove_domain(els) {
  els.selectAll(".domain").remove();
}

function not_integer(x) {
  return x % 1 !== 0;
}

function add_blur_filter(svg) {
  svg.append("defs").html(`
    <filter id="blur_filter" x="0" y="0">
      <feGaussianBlur in="SourceGraphic" stdDeviation="10" />
    </filter>
  `);
}

d3.selection.prototype.select_append = function (query) {
  const [el_type, specifier] = query.split(/\.|#/g);

  let sel = this.select(query);
  if (sel.size() === 0) {
    sel = this.append(el_type);
    if (specifier) {
      const specifier_is_id = query.includes("#");
      sel.attr(specifier_is_id ? "id" : "class", specifier);
    }
  }

  return sel.raise();
};

d3.selection.prototype.move_to = function ({ x = 0, y = 0 }) {
  this.each(function (d) {
    const x_pos = typeof x === "function" ? x(d) : x;
    const y_pos = typeof y === "function" ? y(d) : y;
    d3.select(this).attr("transform", `translate(${x_pos},${y_pos})`);
  });

  return this;
};

function setup_interactions(el, interaction_fns) {
  // wire up the interactions
  for (let type in interaction_fns) {
    el.on(type, interaction_fns[type]);
  }
}
