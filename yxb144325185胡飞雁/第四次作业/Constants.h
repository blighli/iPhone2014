
#ifndef Project3_Constants_h
#define Project3_Constants_h
typedef enum
{
    kLineShape =0,
    kRectShape,
    kEllipseShape,
    kImageShape
}ShapeType;

typedef enum
{
    kRedColorTab=0,
    kBlueColorTab,
    kYellowColorTab,
    kGreenColorTab,
    kRandomColorTab
}ColorTabIndex;

#define degreesToRadian(x) (M_PI * (x) / 180.0)

#endif
