#load Quality.txt file
Quality <- read.delim("Quality.txt") #speciry working directory

#split variable Assembly.Directory into each of the respecitive input parameters
Quality$fp <- as.factor(gsub("_.*", "", gsub(".*fp", "", Quality$Assembly.Directory) ) ) # fp
Quality$fn <- as.factor(gsub("_.*", "", gsub(".*fn", "", Quality$Assembly.Directory) ) )# fn
Quality$pval <- as.factor(gsub("_.*", "", gsub(".*pval", "", Quality$Assembly.Directory) ) )# Pvalues
Quality$minlen <- as.factor(gsub("_.*", "", gsub(".*minlen", "", Quality$Assembly.Directory) ) )#minlen
Quality$minsites <- as.factor(gsub("_.*", "", gsub(".*minsites", "", Quality$Assembly.Directory) ) )#minsite

#install and load ggplot2 package for graphing
if (!require("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

library(ggplot2)

#creating the plot
param_graph <- ggplot(data = Quality, #specify input data
       aes(x = Length.in.Basepairs, y = Contig.Count)) + #specify x and y
  geom_point(aes(color = minlen, #data as points, specify color 
                 shape = pval, #specify shape
                 size = minsites), #specify size
             alpha = .6) + #add transparency to points so you can see overlaps
  scale_size_manual(values = c(3, 5, 7)) + #specify size of points
#  facet_grid(fp ~ fn, labeller = label_both) + #plot split into subplots w/ labels
  theme_bw() + #change the aesthetics of graph with white background
  scale_x_continuous(labels = function(x) x/1000000) + #convert bp to mb for x
  labs(x = "Length (MB)", #x axis label
       y = "Contig Count") + #y axis label
  scale_color_manual(
    values = c("#d7191c", "#fdae61", "#2c7bb6")) + #colors red, yellow, blue
  scale_shape_discrete(solid = TRUE) #fill in shapes

#save the plot
ggsave(filename = "param_graph.png", #file extension will speciry type
       plot = param_graph, #which plot to save
       width = 190, #width of plot
       height = 190, #height of plot
       units = "mm", #units used for width and height 
       dpi = 600) #resolution