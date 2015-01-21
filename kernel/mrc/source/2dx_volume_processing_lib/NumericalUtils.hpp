/* 
 * File:   NumericalUtils.hpp
 * Author: biyanin
 *
 * Created on January 19, 2015, 7:52 PM
 */

#ifndef NUMERICALUTILS_HPP
#define	NUMERICALUTILS_HPP

#include <math.h>

#include "CommonDefinitions.hpp"

int sign(int value);

Reflection averageReflectionsFromList(ReflectionList reflections);

double fomToXarg(double fom);
double i0(double value);
double i1(double value);

#endif	/* NUMERICALUTILS_HPP */

