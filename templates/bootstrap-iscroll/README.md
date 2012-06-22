Template name: bootstrap-iscroll
Type: Responsive Web
Description: Uses Bootstrap for responsive styling, and iScroll4 for mobile display

How does it differ from normal Bootstrap/iScroll? Why is this a good candidate for a template?

- Bootstrap is dumb: .visible-phone kicks in at 767, not 480
- uses unique ids for iScroll elements, not the canned "wrapper", "header" and "footer"
- wraps iScroll styles in a media query

Dependencies:

- jQuery
- Bootstrap
- iScroll
