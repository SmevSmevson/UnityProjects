Shader "Cutout/WorldSpace/Diffuse_Normal" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_BumpScale ("Bump Scale", Float) = 1.0
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Radius ("Radius", float) = 0.25
		_StartPosition ("StartPosition", Vector) = (0,0,0)
      	_EndPosition ("EndPosition", Vector) = (0,0,0)
	}

	SubShader {
		Tags { "RenderType"="Opaque" }

		LOD 400

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows //alphatest:_Cutoff
 		
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0
				
		struct Input {
	        float4 color : COLOR;
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 worldPos;
            float3 worldNormal; INTERNAL_DATA
        };

		sampler2D _MainTex;
		float4 _MainTex_ST;
		sampler2D _BumpMap;
		float _BumpScale;

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		half _Radius;
		float3 _StartPosition;
       	float3 _EndPosition;

		void surf (Input IN, inout SurfaceOutputStandard o) {

			fixed4 c;
			half4 n;

			//this will only look good over short distances
			for(int i = 0; i < 50; i++)
			{
				float3 l = lerp(_StartPosition, _EndPosition, i*.02);
				half dist = distance( IN.worldPos, l);
	          	clip (dist - _Radius);
          	}


	        float3 correctWorldNormal = WorldNormalVector(IN, float3( 0, 0, 1 ) );
            float2 uv = IN.worldPos.zx + _MainTex_ST.zw;
            
            if( abs( correctWorldNormal.x ) > 0.5 ) uv = IN.worldPos.zy + _MainTex_ST.zw;
            if( abs( correctWorldNormal.z ) > 0.5 ) uv = IN.worldPos.xy + _MainTex_ST.zw;

            uv.x *= _MainTex_ST.x;
            uv.y *= _MainTex_ST.y;

            c = tex2D (_MainTex, uv);
            n = tex2D (_BumpMap, uv);
			
			o.Albedo = (c.rgb * _Color);
			o.Normal = UnpackScaleNormal(n, _BumpScale);
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;

		}
		ENDCG
	} 
	FallBack "Diffuse"

}
