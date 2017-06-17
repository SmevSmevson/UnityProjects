Shader "Cutout/UVSpace/Diffise_Normal_Emission_UV" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_BumpScale ("Bump Scale", Float) = 1.0
		[HDR]_EmissionColor("Emmisive Color", Color) = (0,0,0)
		_EmissionMap("Emission", 2D) = "white" {}
		_Radius ("Radius", float) = 0.25
		_StartPosition ("StartPosition", Vector) = (0,0,0)
      	_EndPosition ("EndPosition", Vector) = (0,0,0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		//Cull off
		LOD 400

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
		 		
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
		//float4 _MainTex_ST;
		sampler2D _BumpMap;
		sampler2D _EmissionMap;

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		fixed4 _EmissionColor;
		float _BumpScale;

		half _Radius;
		float3 _StartPosition;
       	float3 _EndPosition;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard o) {

			//this will only look good over short distances
			for(int i = 0; i < 50; i++)
			{
				float3 l = lerp(_StartPosition, _EndPosition, i*.02);
				half dist = distance( IN.worldPos, l);
	          	clip (dist - _Radius);
          	}

			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 e = tex2D (_EmissionMap, IN.uv_MainTex);
			half4 n = tex2D (_BumpMap, IN.uv_MainTex);;

			o.Albedo = (c.rgb * _Color);
			o.Normal = UnpackScaleNormal(n, _BumpScale);
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Emission = e.rgb * _EmissionColor.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
