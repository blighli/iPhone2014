<p class="p1">
<span class="s1"></span>
</p>
<p class="p1">
<span class="s1">1. UI</span><span class="s2">设计：</span>
</p>
<p class="p2">
<span class="s3">![image](<a href="https://github.com/ever223/iPhone2014/blob/master/21451080%E8%82%96%E5%B9%B2/project2/Calculator/pictrues/UI.png"><span class="s4">https://github.com/ever223/iPhone2014/blob/master/21451080%E8%82%96%E5%B9%B2/project2/Calculator/pictrues/UI.png</span></a>)</span>
</p>
<p class="p3">
<span class="s5">2. </span><span class="s1">控制输入格式：</span>
</p>
<p class="p3">
<span class="s5">2.1 </span><span class="s1">输入</span><span class="s5">“ . ”</span><span class="s1">时，若前面无整数，则自动补为</span><span class="s5">&quot; 0. &quot;</span>
</p>
<p class="p3">
<span class="s5">2.2 </span><span class="s1">若正在输入的数值已经包含小数点，则</span><span class="s5"><span>	</span>”.&quot;&nbsp; </span><span class="s1">按钮不可用</span>
</p>
<p class="p3">
<span class="s5">2.3 </span><span class="s1">匹配左右括号数。若已输入</span><span class="s5">“</span><span class="s1">（</span><span class="s5"> “ </span><span class="s1">数和</span><span class="s5"> “ </span><span class="s1">）</span><span class="s5">”</span><span class="s1">数已经匹配，则</span><span class="s5"> ” </span><span class="s1">）</span><span class="s5">”</span><span class="s1">按钮不可用</span>
</p>
<p class="p3">
<span class="s5">2.4 </span><span class="s1">若显示的最后一个字符是</span><span class="s5"><span>	</span>“</span><span class="s1">数字</span><span class="s5"> ”<span>	</span></span><span class="s1">或者</span><span class="s5"> <span>	</span>“ </span><span class="s1">）</span><span class="s5">” </span><span class="s1">，则</span><span class="s5"> “ </span><span class="s1">（</span><span class="s5"> ”</span><span class="s1">按钮</span><span class="s5"> </span><span class="s1">不可用</span>
</p>
<p class="p1">
<span class="s1">2.5 </span><span class="s2">若显示的最后一个字符是操作符</span><span class="s1"> “+ </span><span class="s2">－</span><span class="s1"> × ÷&nbsp; ”</span><span class="s2">，则</span><span class="s1">“+ </span><span class="s2">－</span><span class="s1"> × ÷&nbsp; ”</span><span class="s2">和</span><span class="s1"> “ </span><span class="s2">）</span><span class="s1">”</span><span class="s2">按钮不可用</span>
</p>
<p class="p3">
<span class="s5">2.6 </span><span class="s1">若显示的最后一个字符是操作符</span><span class="s5"> “</span><span class="s1">（</span><span class="s5">”</span><span class="s1">，则</span><span class="s5">“&nbsp; × ÷&nbsp; ”</span><span class="s1">和</span><span class="s5"> “ </span><span class="s1">）</span><span class="s5">”</span><span class="s1">按钮不可用</span>
</p>
<p class="p3">
<span class="s5">2.7 </span><span class="s1">自动去除数字前的</span><span class="s5">”0“</span>
</p>
<p class="p3">
<span class="s5">2.8 </span><span class="s1">若输入的前一个操作是</span><span class="s5">“ </span><span class="s1">＝</span><span class="s5">”</span><span class="s1">，则标记。下一个按下的按钮如果是数字按钮，则清除屏幕，再进行显示；若下一个按钮的按钮时操作符，则继续输入</span>
</p>
<p class="p3">
<span class="s5">2.9 </span><span class="s1">若若显示的最后一个字符是操作符</span><span class="s5"> “+ </span><span class="s1">－</span><span class="s5"> × ÷&nbsp; ” </span><span class="s1">或者左右括号不匹配，则</span><span class="s5">“</span><span class="s1">＝</span><span class="s5">”</span><span class="s1">按钮不可用</span>
</p>
<p class="p3">
<span class="s5">2.10 </span><span class="s1">若显示的最后一个字符是操作符</span><span class="s5"> “</span><span class="s1">（</span><span class="s5">” </span><span class="s1">或</span><span class="s5">“</span><span class="s1">）</span><span class="s5">”</span><span class="s1">，则</span><span class="s5">“ </span><span class="s1">数字</span><span class="s5">”</span><span class="s1">按钮不可用</span>
</p>
<p class="p3">
<span class="s1">等等</span>
</p>
<p class="p3">
<span class="s5">3. </span><span class="s1">计算功能实现：</span>
</p>
<p class="p3">
<span class="s1">测试结果如图：</span>
</p>
<p class="p2">
<span class="s3">![image](<a href="https://github.com/ever223/iPhone2014/blob/master/21451080%E8%82%96%E5%B9%B2/project2/Calculator/pictrues/test.png"><span class="s4">https://github.com/ever223/iPhone2014/blob/master/21451080%E8%82%96%E5%B9%B2/project2/Calculator/pictrues/test.png</span></a>)</span><span class="s6"><span>	</span><span>	</span></span>
</p>
<p class="p1">
<span class="s1">4. M</span><span class="s2">功能测试</span><span class="s1">&nbsp;</span>
</p>
<p class="p2">
<span class="s3">![image](<a href="https://github.com/ever223/iPhone2014/blob/master/21451080%E8%82%96%E5%B9%B2/project2/Calculator/pictrues/m.png"><span class="s4">https://github.com/ever223/iPhone2014/blob/master/21451080%E8%82%96%E5%B9%B2/project2/Calculator/pictrues/m.png</span></a>)</span><span class="s6"><span>	</span></span>
</p>
<p class="p3">
<span class="s5">5.<span>	</span></span><span class="s1">暂未实现功能：</span>
</p>
<p class="p3">
<span class="s1">％</span><span class="s5"> </span><span class="s1">号</span><span class="s5"><span>	</span></span>
</p>
<p class="p3">
<span style="white-space:pre"></span>
</p>