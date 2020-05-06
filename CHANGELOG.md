## [2.0.0] - Support for Any Number of Segments
* Adds support for any number of segments by instead passing a list of `BorderSides` and argument for the number of segments.

## [1.0.1] - Path Bugfix
* Fix clipping bug due to subpaths being created by addArc by using arcTo instead
* Remove custom `==` operator

## [1.0.0] - Initial Release

* Provides a segmented circle border which provides individual eighths of the circle, and offset to allow re-alignment of segments.
