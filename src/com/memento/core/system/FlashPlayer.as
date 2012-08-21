﻿/** * Copyright 2011 by Barnabás Bucsy * * This file is part of The Memento Framework. * * The Memento Framework is free software: you can redistribute it * and/or modify it under the terms of the GNU Lesser General Public * License as published by the Free Software Foundation, either * version 3 of the License, or (at your option) any later version. * * The Memento Framework is distributed in the hope that it will be * useful, but WITHOUT ANY WARRANTY; without even the implied warranty * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU * Lesser General Public License for more details. * * You should have received a copy of the GNU Lesser General Public * License along with The Memento Framework. If not, see * <http://www.gnu.org/licenses/>. */package com.memento.core.system{	import flash.system.Capabilities;	import com.memento.utils.NumberUtil;	/**	 * STATIC Class for checking Flash Player	 */	public class FlashPlayer	{		/**		 * Flash player OS.		 */		private static var __os:String;		/**		 * Flash player debugger.		 */		private static var __debugger:Boolean;		/**		 * Flash player major version.		 */		private static var __major:uint;		/**		 * Flash player minor version.		 */		private static var __minor:uint;		/**		 * Flash player build version.		 */		private static var __build:uint;		/**		 * Flash player internal version.		 */		private static var __internal:uint;		/**		 * Flash player internal version.		 */		private static var __inited:Boolean;		/**		 * Constructor		 * @throws Error Static Class.		 */		public function FlashPlayer( ):void		{			throw new Error( 'Tried to instantiate static class!' );		}		/**		 * Initialozer function.		 */		private static function init( ):void		{			var v:Array = Capabilities.version.split( /\s|,/ );			__os        = v[ 0 ].toString( ).toLowerCase( );			__major     = NumberUtil.NaNToZero( parseInt( v[ 1 ] ) );			__minor     = NumberUtil.NaNToZero( parseInt( v[ 2 ] ) );			__build     = NumberUtil.NaNToZero( parseInt( v[ 3 ] ) );			__internal  = NumberUtil.NaNToZero( parseInt( v[ 4 ] ) );			__debugger  = Capabilities.isDebugger;			__inited    = true;		}		/**		 * Getter function for operating system of Flash Player.		 * @return String The OS for which the Player was compiled.		 */		public static function get OS( ):String		{			if ( !__inited )			{				init( );			}			return __os;		}		/**		 * Getter function for major version of Flash Player.		 * @return uint Major version of Flash Player.		 */		public static function get MAJOR( ):uint		{			if ( !__inited )			{				init( );			}			return __major;		}		/**		 * Getter function for minor version of Flash Player.		 * @return uint Minor version of Flash Player.		 */		public static function get MINOR( ):uint		{			if ( !__inited )			{				init( );			}			return __minor;		}		/**		 * Getter function for build version of Flash Player.		 * @return uint Build version of Flash Player.		 */		public static function get BUILD( ):uint		{			if ( !__inited )			{				init( );			}			return __build;		}		/**		 * Getter function for build version of Flash Player.		 * @return uint Internal version of Flash Player.		 */		public static function get INTERNAL( ):uint		{			if ( !__inited )			{				init( );			}			return __internal;		}		/**		 * Getter function for debugger version of Flash Player.		 * @return uint Is this the debugger version of Flash Player.		 */		public static function get DEBUGGER( ):Boolean		{			if ( !__inited )			{				init( );			}			return __debugger;		}		/**		 * Checks if Player's version is equal or higher than presented one.		 * @param major_ uint Minimal major version.		 * @param minor_ uint Minimal minor version.		 * @param build_ uint Minimal build version.		 * @param internal_ uint Minimal internal version.		 * @return Boolean Whether version check passed.		 */		public static function hasVersion( major_:uint, minor_:uint, build_:uint, internal_:uint = 0 ):Boolean		{			if ( !__inited )			{				init( );			}			if ( __major > major_ )			{				return true;			}			else if ( __major == major_ )			{				if ( __minor > minor_ )				{					return true;				}				else if ( __minor == minor_ )				{					if ( __build > build_ )					{						return true;					}					else if ( __build == build_ )					{						if ( __internal >= internal_ )						{							return true;						}					}				}			}			return false;		}	}}