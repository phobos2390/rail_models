all:
	openscad -o railtie_cross_section.stl railtie_cross_section.scad
	openscad -o rail_cart.stl rail_cart.scad

clean:
	rm -rf railtie_cross_section.stl rail_cart.stl
