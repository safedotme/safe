interface DataBoxProps {
  heading: string;
  data: string;
  children: React.ReactNode;
  isDark: boolean;
}

const DataBox = (props: DataBoxProps) => {
  return (
    <div
      className={`rounded-[10px] border-[2px] ${
        props.isDark
          ? "border-white/[0.15] bg-[#080608]/[0.4]"
          : "border-[#676767]/[0.15] bg-[#D2D2D2]/[0.4]"
      } p-[7px] backdrop-blur-[15px] backdrop-filter`}
    >
      <div className="flex flex-row space-x-[3px]">
        {props.children}
        <p
          className={`text-[0.75rem] font-[600] ${
            props.isDark ? "text-[#5C5C5C]" : "text-[#8A8A8A]"
          }`}
        >
          {props.heading.toUpperCase()}
        </p>
      </div>
      <p
        className={`text-[0.8rem] font-[600] ${
          props.isDark ? "text-[#C7C7C7]" : "text-[#464646]"
        }`}
      >
        {props.data.toUpperCase()}
      </p>
    </div>
  );
};

export default DataBox;
