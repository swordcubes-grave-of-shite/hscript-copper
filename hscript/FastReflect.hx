package hscript;

class FastReflect {
	public static inline function field(obj:Dynamic, field:String):Dynamic {
		#if cpp
		return untyped __cpp__("({0})->__Field({1}, hx::paccNever)", obj, field);
		#else
		return Reflect.field(obj, field);
		#end
	}

    public static inline function getProperty(obj:Dynamic, field:String):Dynamic {
		#if cpp
		return untyped __cpp__("({0})->__Field({1}, hx::paccAlways)", obj, field);
		#else
		return Reflect.getProperty(obj, field);
		#end
	}

	public static inline function setField(obj:Dynamic, field:String, value:Dynamic):Void {
		#if cpp
		untyped __cpp__("({0})->__SetField({1}, {2}, hx::paccNever)", obj, field, value);
		#else
		Reflect.setField(obj, field, value);
		#end
	}
    
    public static inline function setProperty(obj:Dynamic, field:String, value:Dynamic):Void {
		#if cpp
		untyped __cpp__("({0})->__SetField({1}, {2}, hx::paccAlways)", obj, field, value);
		#else
		Reflect.setProperty(obj, field, value);
		#end
	}

	public static inline function callMethod(obj:Dynamic = null, fn:Dynamic, args:Array<Dynamic>):Dynamic {
		#if cpp
		return switch (args.length) {
			case 0: untyped __cpp__('{0}()', fn);
			case 1: untyped __cpp__('{0}({1})', fn, args[0]);
			case 2: untyped __cpp__('{0}({1},{2})', fn, args[0], args[1]);
			case 3: untyped __cpp__('{0}({1},{2},{3})', fn, args[0], args[1], args[2]);
			default: Reflect.callMethod(obj, fn, args);
		}
		#else
		return Reflect.callMethod(obj, fn, args);
		#end
	}

	public static inline function hasField(obj:Dynamic, field:String):Bool {
        #if cpp
    	return untyped __cpp__("({0})->__HasField({1})", obj, field);
    	#else
    	return Reflect.hasField(obj, field);
    	#end
	}

	public static inline function fields(obj:Dynamic):Array<String> {
		// TODO: find a cpp version of this
    	return Reflect.fields(obj);
	}

	public static inline function isFunction(v:Dynamic):Bool {
		#if cpp
		if (v == null || v == false || v == true) return false;
		return untyped __cpp__("{0}.mPtr && {0}.mPtr->__GetType() == 2", v);
		#else
		return Reflect.isFunction(v);
		#end
	}
}