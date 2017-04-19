﻿Shader "Unlit/Looping" {
Properties {
   _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
   _Color ("Color", Color) = (1,1,1,1)
}
 
SubShader {
   Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
   LOD 100
 
   ZWrite Off
   Fog { Mode Off }
   Blend One OneMinusSrcAlpha
     
   Pass {
     CGPROGRAM
       #pragma vertex vert
       #pragma fragment frag
     
       #include "UnityCG.cginc"
 
       struct appdata_t {
         float4 vertex : POSITION;
         float2 texcoord : TEXCOORD0;
       };
 
       struct v2f {
         float4 vertex : SV_POSITION;
         half2 texcoord : TEXCOORD0;
       };
 
       sampler2D _MainTex;
	   float4 _MainTex_ST;
       float4 _Color;
     
       v2f vert (appdata_t v)
       {
         v2f o;
         o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
         o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
         return o;
       }
     
       fixed4 frag (v2f i) : COLOR
       {
       		i.texcoord.x = fmod(i.texcoord.x, 1);
			i.texcoord.y = fmod(i.texcoord.y, 1);
       
         	fixed4 col = _Color*tex2D(_MainTex, i.texcoord);         
                  
         	col.rgb *= col.a;
         	return col;
       }
     ENDCG
   }
}
}