blueprint.square = function(plots, label=TRUE) {
	N = length(plots)
	stopifnot(N == 4)
	plot = ggdraw() + draw_plot(plots[[1]], 0,.5,.5,.5) + draw_plot(plots[[2]], .5,.5,.5,.5) + draw_plot(plots[[3]], 0,0,.5,.5) + draw_plot(plots[[4]],.5,0,.5,.5)
	if(label)
		plot = plot + draw_plot_label(c('A','B','C','D'), c(0,.5,0,.5),c(1,1,.5,.5))
	plot
}

blueprint.line = function(plots, label=TRUE) {
	N = length(plots)
	width = 1/N
	plot = ggdraw() 
	x = 0
	alphabet = c('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')

	for(i in 1:N) {
		plot = plot + draw_plot(plots[[i]], x, 0, width, 1)
		if(label)
			plot = plot + draw_plot_label(alphabet[i],x)
		x = x + width	
	}

	plot
}

blueprint.left_feature = function(plots, label=TRUE) {
	N = length(plots)
	stopifnot(N > 2)
	M = N - 1
	height = 1 / M
	alphabet = c('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')
	plot = ggdraw() 
	plot = plot + draw_plot(plots[[1]], 0, 0, .5, 1)
	
	if(label)
		plot = plot + draw_plot_label(alphabet[1], 0)
	
	y = 1 - height
	for(i in 2:N) {
		plot = plot + draw_plot(plots[[i]], .5, y, .5, height)
		if(label)
			plot = plot + draw_plot_label(alphabet[i],.5, y+height)
		y = y - height	
	}

	plot
}

#' Layout function
#'
#' This function provides an interface to plot common layouts for ggplot2
#'
#' @export
#' @examples
#' blueprint('square', plot1, plot2, plot3, plot4)
#' blueprint('square', plot1, plot2, plot3, plot4, label=F)
blueprint = function(layout, ..., label=TRUE) {
	require(ggplot2)
	require(cowplot)
	plots = list(...)
	plot = switch(layout,
		square = blueprint.square(plots, label=label),
		line = blueprint.line(plots, label=label),
		left_feature = blueprint.left_feature(plots, label=label))
	print(plot)
}