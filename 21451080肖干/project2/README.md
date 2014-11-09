
<p class="p1">
<span class="s1">1. UI</span><span class="s2">设计：</span>
</p>
<p class="p1">
<span class="s3"><span style="white-space:pre">	</span>![image](<a href="https://github.com/ever223/iOS-Projects/blob/master/Calculator/pictrues/UI.png"><span class="s4">https://github.com/ever223/iOS-Projects/blob/master/Calculator/pictrues/UI.png</span></a>)</span>
</p>
<p class="p3">
<span class="s5">2.&nbsp;</span><span class="s1">控制输入格式：</span>
</p>
<p class="p3">
<span class="s1"><span style="white-space:pre">	</span>2.1 输入“ . ”时，若前面无整数，则自动补为&quot; 0. &quot;</span>
</p>
<p class="p3">
<span class="s1"><span style="white-space:pre">	</span>2.2 若正在输入的数值已经包含小数点，则<span style="white-space:pre">	</span>”.&quot; &nbsp;按钮不可用</span>
</p>
<p class="p3">
<span class="s1"><span style="white-space:pre">	</span>2.3 匹配左右括号数。若已输入“（ “ 数和 “ ）”数已经匹配，则 ” ）”按钮不可用</span>
</p>
<p class="p3">
<span class="s1"><span style="white-space:pre">	</span>2.4 若显示的最后一个字符是<span style="white-space:pre">	</span>“数字 ”<span style="white-space:pre">	</span>或者 <span style="white-space:pre">	</span>“ ）” ，则 “ （ ”按钮 不可用</span>
</p>
<p class="p3">
<span class="s1"><span style="white-space:pre">	</span>2.5 若显示的最后一个字符是操作符&nbsp;“<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;">+ － × ÷ &nbsp;”，则“<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;">+ － × ÷ &nbsp;”和 “ ）”按钮不可用</span></span></span>
</p>
<p class="p3">
<span style="white-space: pre;">	</span>2.6 若显示的最后一个字符是操作符&nbsp;“<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;">（”，则<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;">“&nbsp;</span><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;">&nbsp;× ÷ &nbsp;”和 “ ）”按钮不可用</span></span>
</p>
<p class="p3">
<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="white-space:pre">	</span>2.7 自动去除数字前的”0“</span></span>
</p>
<p class="p3">
<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="white-space:pre">	</span>2.8 若输入的前一个操作是“ ＝”，则标记。下一个按下的按钮如果是数字按钮，则清除屏幕，再进行显示；若下一个按钮的按钮时操作符，则继续输入</span></span>
</p>
<p class="p3">
<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="white-space:pre">	</span>2.9 若若显示的最后一个字符是操作符&nbsp;“<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;">+ － × ÷ &nbsp;” 或者左右括号不匹配，则“＝<span style="line-height: 20.0200004577637px;">”按钮不可用</span></span></span></span>
</p>
<p class="p3">
<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="line-height: 20.0200004577637px;"><span style="white-space:pre">	</span>2.10&nbsp;若显示的最后一个字符是操作符&nbsp;“<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;">（” 或“）”，则“ 数字<span style="line-height: 20.0200004577637px;">”按钮不可用</span></span></span></span></span></span>
</p>
<p class="p3">
<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="line-height: 20.0200004577637px;"><span style="white-space:pre">	</span>等等</span></span></span></span></span></span>
</p>
<p class="p3">
<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;">3. 计算功能实现：</span></span>
</p>
<p class="p3">
<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="white-space:pre">	</span>测试结果如图：</span></span>
</p>
<p class="p3">
<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px;"><span style="white-space:pre">	![image](<a href="https://github.com/ever223/iOS-Projects/blob/master/Calculator/pictrues/UI.png"><span class="s4">https://github.com/ever223/iOS-Projects/blob/master/Calculator/pictrues/test.png</span></a>)	</span><span style="white-space:pre">	</span></span></span>
</p>
<p class="p3">
4. M功能测试&nbsp;

</p>
<p>
    ![image](https://github.com/ever223/iOS-Projects/blob/master/Calculator/pictrues/UI.png）
</p>
<p class="p3">
<span style="white-space:pre">	<span style="color: rgb(51, 51, 51); font-family: arial; font-size: 13px; line-height: 20.0200004577637px; white-space: pre;">![image](<a href="https://github.com/ever223/iOS-Projects/blob/master/Calculator/pictrues/UI.png"><span class="s4">https://github.com/ever223/iOS-Projects/blob/master/Calculator/pictrues/m.png</span></a>)	</span></span>
</p>
<p class="p3">
<span style="white-space:pre">5.<span style="white-space:pre">	</span>暂未实现功能：</span>
</p>
<p class="p3">
<span style="white-space:pre"><span style="white-space:pre">	</span>％ 号	</span>
</p>