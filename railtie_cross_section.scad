$fn = 20;
$scale = 1.5;

// Rail
$rail_extrusion_length=50 * $scale;
$rail_length=6 * $scale;
$rail_widthtop=2 * $scale;
$rail_widthbottom=6.5 * $scale;   // 6.61 mm = 26.44 mm / 4
$rail_topheight=.75 * $scale;   
$rail_bevelsize=.5 * $scale;
$rail_widthcenter=.75 * $scale;
$rail_bottomheight=1 * $scale;

// Cross Beam
$cross_thickness=6.5 * $scale;
$cross_depressionwidth=6.5 * $scale;
$cross_depressionheight=1.2 * $scale;
$cross_tolerance=0.2 * $scale;
$cross_width=32.5 * $scale;
$cross_height=4 * $scale;
$cross_grade=20 * $scale;

$distance_between=60 * $scale;
$circle_distance=10 * $scale;

module tie_cross_section( length
                        , widthtop
                        , widthbottom
                        , widthcenter
                        , bevelsize
                        , topheight
                        , bottomheight)
{
    union()
    {
        square([widthcenter,length], center=true);
        translate([0,length/2,0])
        {
            difference()
            {
                minkowski()
                {
                    square([widthtop,topheight], center=true);
                    circle(bevelsize);
                }
                translate([0,-topheight])
                {
                    square([widthtop + topheight*2,topheight], center=true);
                }
            }
        }
        translate([0,-length/2,0])
        {
            square([widthbottom,bottomheight], center=true);
        }
    }

};

module tie_beam_cross_section( width
                             , height
                             , depressionwidth
                             , depressionheight
                             , tolerance
                             , grade)
{
    h_width=width/2;
    q_height=height/4;
    h_grade=grade/2;
    difference()
    {
        square([width,height],center=true);
        translate([h_grade,q_height,0])
        {
            square( [ depressionwidth+tolerance*2
                    , depressionheight]
                  , center=true);

            translate([0,tolerance,0])
            {
                square( [ depressionwidth-tolerance
                        , depressionheight+tolerance*2]
                      , center=true);
            }
        }
        translate([-h_grade,q_height,0])
        {
            square( [ depressionwidth+tolerance*2
                    , depressionheight]
                  , center=true);
            translate([0,tolerance,0])
            {
                square( [ depressionwidth-tolerance
                        , depressionheight+tolerance*2]
                      , center=true);
            }
        }
    }
}


//*/
#for(i = [0:30:360])
{
translate([0,$distance_between,0])
{
    rotate(i, [0,0,1])
    {
        translate([0,-$circle_distance,0])
        {
//            linear_extrude($rail_extrusion_length, center=true)
            linear_extrude($rail_extrusion_length)
            {
                tie_cross_section
                    ( length=$rail_length
                    , widthtop=$rail_widthtop
                    , widthbottom=$rail_widthbottom
                    , topheight=$rail_topheight   
                    , bevelsize=$rail_bevelsize
                    , widthcenter=$rail_widthcenter
                    , bottomheight=$rail_bottomheight);
            }
        }
    }
}
}
//*/
for(i = [0:$cross_height+$cross_tolerance:10*($cross_height+$cross_tolerance)])
{
    translate([0,i,0])
    {
//        linear_extrude($cross_thickness, center=true)
        linear_extrude($cross_thickness)
        {
            tie_beam_cross_section( depressionwidth=$cross_depressionwidth
                                  , depressionheight=$cross_depressionheight
                                  , tolerance=$cross_tolerance
                                  , width=$cross_width
                                  , height=$cross_height
                                  , grade=$cross_grade);
        }
    }
}
for(i = [$cross_height+$cross_tolerance:$cross_height+$cross_tolerance:10*($cross_height+$cross_tolerance)])
{
    translate([0,-i,0])
    {
//        linear_extrude($cross_thickness, center=true)
        linear_extrude($cross_thickness)
        {
            tie_beam_cross_section( depressionwidth=$cross_depressionwidth
                                  , depressionheight=$cross_depressionheight
                                  , tolerance=$cross_tolerance
                                  , width=$cross_width
                                  , height=$cross_height
                                  , grade=$cross_grade);
        }
    }
}

/*/
rotate(90, [1,0,0])
{
    union()
    {
        translate([-10,0,0])
        {
            linear_extrude(50, center=true)
            {
                tie_cross_section
                    ( length=$rail_length
                    , widthtop=$rail_widthtop
                    , widthbottom=$rail_widthbottom
                    , topheight=$rail_topheight   
                    , bevelsize=$rail_bevelsize
                    , widthcenter=$rail_widthcenter
                    , bottomheight=$rail_bottomheight);
            }
        }
        translate([10,0,0])
        {
            linear_extrude(50, center=true)
            {
                tie_cross_section
                    ( length=$rail_length
                    , widthtop=$rail_widthtop
                    , widthbottom=$rail_widthbottom
                    , topheight=$rail_topheight   
                    , bevelsize=$rail_bevelsize
                    , widthcenter=$rail_widthcenter
                    , bottomheight=$rail_bottomheight);
            }
        }
        translate([0,-4,0])
        {
            linear_extrude($cross_thickness, center=true)
            {
                tie_beam_cross_section( depressionwidth=$cross_depressionwidth
                                      , depressionheight=$cross_depressionheight
                                      , tolerance=$cross_tolerance
                                      , width=$cross_width
                                      , height=$cross_height
                                      , grade=$cross_grade);
            }
        }
    }
}

//*/
